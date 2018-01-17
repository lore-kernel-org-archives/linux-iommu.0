From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] iommu/msm: Claim bus ops on probe
Date: Wed, 17 Jan 2018 14:53:56 +0100
Message-ID: <20180117135356.GQ28161@8bytes.org>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
 <20180117133331.vidtyduiu7zr3fwc@8bytes.org>
 <bc83496f-f0c0-6fe7-acd4-b96526a81dc3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <bc83496f-f0c0-6fe7-acd4-b96526a81dc3@arm.com>
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
Cc: architt@codeaurora.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, srinivas.kandagatla@linaro.org, sricharan@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Wed, Jan 17, 2018 at 01:39:18PM +0000, Robin Murphy wrote:
> Oops, patch #2 of this series will break the build, as it was accidentally
> based on an older branch missing the Renesas IPMMU updates. 

So patch #2 needs the ipmmu-patch from your v2 post to build? I am a bit
confused...

> Please see v2 [1] - I'm still hoping for confirmation from the Renesas
> folks, but it *should* be fine...

I can apply the patches again from your v2 post, thats fine, I just want
to understand the dependencies first.


> Incidentally, per your other mail, these changes also makes Jeffy's "Only do
> IOMMU lookup for available ones" patch obsolete.

Okay, thanks for letting me know.


Thanks,

	Joerg
