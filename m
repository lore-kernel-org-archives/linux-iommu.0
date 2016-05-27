From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT v2] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Fri, 27 May 2016 02:12:43 +0200
Message-ID: <20160527001243.GP11948@wotan.suse.de>
References: <CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw@mail.gmail.com>
	<570BA694.8040900@amd.com>
	<CAFCwf10oD9c3MOW3+J8A5MVjVkX0nNRGCEE2pWcQxOy7mjUsBw@mail.gmail.com>
	<570BAC2B.4090508@amd.com> <20160412220715.GL1990@wotan.suse.de>
	<CAFCwf12SJ-dTv6PC0_KfHbtC9951xb_4v8wu5uSjXO-V3TgdkA@mail.gmail.com>
	<CAB=NE6WL7j_azrFxQUG3bybXtu67ew51CyzYvkBct6tCdARKDg@mail.gmail.com>
	<CAFCwf12B6TQ5kYEG4+hYoWriv2rnTcngQLX_Cvtbz=64fo35Qg@mail.gmail.com>
	<20160418120350.GE1990@wotan.suse.de> <571591CC.40700@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571591CC.40700-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 19, 2016 at 10:02:52AM +0800, Wan Zongshun wrote:
> 
> You have to take carefully to arrange the calling sequence for
> iommuv1, iommuv2, kfd module, and drm like the following sequence :
> v1 ->v2->kfd, drm.
> 
> iommuv1 -- rootfs_initcall(fn)
> IOMMUV2 -- device_initcall(fn)
> kfd module -- late_initcall(fn)
> drm -- late_initcall(fn)

Thanks, it turns out this is not exactly enough, given as 
Joerg notes:

--
AMD-KFD on the other hand needs to be loaded before the                                                                                          
radeon driver (but this it not enforced by symbols), because otherwise                                                                                        
the radeon driver will not initialize the AMD-KFD driver. 
---

We have a theoretical race still possible between the kfd module
and the drm driver. I'll reply to Joerg's e-mail with more feedback.

  Luis
