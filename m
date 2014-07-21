From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 00/13] Add support for Hisilicon SMMU architecture
Date: Mon, 21 Jul 2014 10:39:51 +0100
Message-ID: <20140721093951.GC16122@arm.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
	<53CC7234.4080703@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53CC7234.4080703-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Lizefan <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[re-adding the lists]

On Mon, Jul 21, 2014 at 02:51:48AM +0100, leizhen wrote:
> Hi, Will

Hello,

> I have sent this patch a week ago. I saw that you and Mitchel Humpherys had
> sent some patches which will impact my code. I list below:
> iommu/arm-smmu: remove support for chained SMMUs
> iommu/arm-smmu: fix some checkpatch issues

There's also all of the development work I'm doing for VFIO and the page-table
rework that Varun's working on, so these patches are going to be difficult
to merge if we ever get to that point. I think Mitchel and Olav are also
busy trying to get their SMMU supported by the driver. Given that they've
actually bothered to follow the architecture, I don't see why they should
be messed about by your patches causing conflicts all over the place.

> I can ajust my patch because of above. I known this patch is not follow what
> you suggested before(fit into arm-smmu.c). But I found when we need to support
> ARM SMMUv3, maybe we should do like this. I really want to know whether or not
> you agree the software framework in this patch? Or what do you think about
> SMMUv3?

The only code I foresee sharing between SMMUv2 and SMMUv3 is the page-table
creation code. The two architectures are significantly different, so I don't
think your split really helps us there. For example, you've left the probing
code in smmu-base.c. Of course, if HiSilicon follow the SMMUv3 spec as well
they did with SMMUv2, then your point is moot anyway and we may as well go
home.

> > I tried to merge hisi-smmu driver into arm-smmu.c, but it looks impossible.
> > The biggest problem is that too many registers are diffrent: the base address,
> > the field definition, or present only on one side. And if I use #if, hisi-smmu
> > and arm-smmu can not coexist in one binary file. Almost need 20 #if.

I don't think #ifdefs are necessarily the right way to go. There are IMPDEF
parts of a compliant SMMU (e.g. power management), so having a new compatible
string and a set of internal ops which can be overridden by a particular
implementation wouldn't be the end of the world and would be far less
invasive.

The problem you have is that your SMMU isn't architecturally compliant, so
you'll end up having to restructure parts of the driver so you can add
internal hooks for operations that aren't actually IMPDEF. That's the part
I'm worried about and we will have to draw the line somewhere, especially
when other people are trying to work with this code for compliant
implementations.

So, NAK to your current approach. You need to try something like I said
above and, if you want to spit the file up, start with the page-table code.

Will
