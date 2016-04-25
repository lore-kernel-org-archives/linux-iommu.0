From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT v2] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Mon, 25 Apr 2016 12:23:51 +0200
Message-ID: <20160425102351.GC17926@8bytes.org>
References: <1459273313-5139-1-git-send-email-mcgrof@kernel.org>
	<CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw@mail.gmail.com>
	<570BA694.8040900@amd.com>
	<CAFCwf10oD9c3MOW3+J8A5MVjVkX0nNRGCEE2pWcQxOy7mjUsBw@mail.gmail.com>
	<570BAC2B.4090508@amd.com> <20160412220715.GL1990@wotan.suse.de>
	<CAFCwf12SJ-dTv6PC0_KfHbtC9951xb_4v8wu5uSjXO-V3TgdkA@mail.gmail.com>
	<CAB=NE6WL7j_azrFxQUG3bybXtu67ew51CyzYvkBct6tCdARKDg@mail.gmail.com>
	<CAFCwf12B6TQ5kYEG4+hYoWriv2rnTcngQLX_Cvtbz=64fo35Qg@mail.gmail.com>
	<20160418120350.GE1990@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160418120350.GE1990-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 18, 2016 at 02:03:50PM +0200, Luis R. Rodriguez wrote:
> You said that with my patch you saw AMD IOMMUv2 kick off first,
> that was intentional as I thought that's what you needed. Can
> someone please describe the requirements?
> 
> Also what does drm use that you say has a conflict already? What
> drm code are we talking about exactly ?

The required order is:

	1. AMD IOMMUv1 (in-kernel only, initialized at boot time after PCI)
	2. AMD IOMMUv2 (in-kernel or as module, provides demand paging
			and uses v1 interfaces to talk to the IOMMU)
	3. AMD-KFD     (Implements compute offloading to the GPU and
			uses AMD IOMMUv2 functionality, also provides a
			symbol for the radeon driver)
	4. DRM with    (Checks if the symbol provided by AMD-KFD is
	   Radeon	available at init time and does the KFD
			initialization from there, because the GPU needs
			to be up first)

So AMD IOMMUv2 does not initialize (but it does load to have the symbols
available for drivers that optionally use its functionality) without the
AMD IOMMUv1 driver, as it can't access the IOMMU hardware then.

AMD-KFD does not load without AMD IOMMUv2 being loaded, as it depends on
its symbols. AMD-KFD on the other hand needs to be loaded before the
radeon driver (but this it not enforced by symbols), because otherwise
the radeon driver will not initialize the AMD-KFD driver.

When AMD-KFD is loaded and you load radeon then, you get the KFD
functionality in the kernel. Then you can move on to the fun getting the
userspace running and actually execute anything on the GPU. But thats
another story.

I know what you think, and I agree: It's a big mess :)

Regards,

	Joerg
