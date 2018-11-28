From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 8/9] iommu: arm-smmu: make it explicitly non-modular
Date: Wed, 28 Nov 2018 10:24:45 -0500
Message-ID: <20181128152445.GH14659@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-9-git-send-email-paul.gortmaker@windriver.com>
 <755c95d7-882c-0dec-207e-20bf8f22b159@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <755c95d7-882c-0dec-207e-20bf8f22b159@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Nate Watterson <nwatters@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

[Re: [PATCH 8/9] iommu: arm-smmu: make it explicitly non-modular] On 28/11/2018 (Wed 12:42) Robin Murphy wrote:

> Hi Paul,
> 
> On 26/11/2018 22:31, Paul Gortmaker wrote:

[...]

> >We add a moduleparam.h include since the file does actually declare
> >some module parameters, and leaving them as such is the easiest way
> >currently to remain backwards compatible with existing use cases.

[...]


> Is it worth introducing builtin_param() and friends for this sort of thing,
> to echo the *_platform_driver() helpers? It seems like that could be
> justifiable under the motivation described in the cover letter.

I've definitely gone back and looked at this a few times when coming
across the few corner cases like these, to remind myself why I didn't do
it already.

We'd not want to replicate all the module_param stuff as an instance of
builtin_param() because we already have setup() and setup_param() in
init.h -- however they don't do the file name in the param - hence the
reason it isn't a direct swap in replacement.

So, it would become some more complex refactoring of moduleparam.h into
say bootparam.h - to reduce code/macro duplication, while at the same
time being aware of existing setup_param stuff and making something like
a new setup_param_named() that is consistent with existing setup fcns.

And based on past experience, there will be reviewers who don't see the
value in the distinction and simply reply with two words "why bother?".

Not impossible, but not as simple as the builtin_platform_driver and
similar wrappers that I've already added to mainline.  You've made we
want to go have another look at it again, but in the meantime we can do
what I've done here, and circle around later to update the few instances
of moduleparam in non-modules once/if the refactoring I describe above
works out and is accepted in mainline.

> 
> Otherwise, the changes look reasonable. I still hold out hope that one day
> we'll be able to make IOMMU drivers modular (it can work with minimal hacks
> today, but it's far from robust in general), but for now I agree this makes
> sense (and it'll be easy enough to revert for playing with further hacks).

I totally agree - I've had similar discussions with the DMA maintainers,
and if being modular can be made to work and has a use case - great!

But it should be a conscious decision, since nobody writes a new driver
from scratch; they copy one that is "close" as a template and then go
from there.  Which leads to a good percentage of drivers having hints
of modular stuff when there is no intent of them ever being modular.

> With the title fixed up as Joerg asked,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks for the feedback/review.  Will re-send with updated titles before
the week is finished and a good chance for additional feedback has elapsed.

Paul.
--

> 
> >  module_param(force_stage, int, S_IRUGO);
> >  MODULE_PARM_DESC(force_stage,
> >  	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
