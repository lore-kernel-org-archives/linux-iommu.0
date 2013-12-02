From: Kim Phillips <kim.phillips@linaro.org>
Subject: Re: [RFC PATCH v2 0/7] VFIO for device tree based platform devices
 (work in progress)
Date: Mon, 2 Dec 2013 16:08:32 +0000
Message-ID: <20131202160832.8f5ee84355086cdb14d6a431@linaro.org>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<20131201120954.1d6cec431a99a7ad5f34da18@linaro.org>
	<CAG8rG2zir5-hXaARvuDbZ=OnX2Zs7suy_DetxYHS++5VrHGZfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAG8rG2zir5-hXaARvuDbZ=OnX2Zs7suy_DetxYHS++5VrHGZfA@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: a.motakis@virtualopensystems.com
Cc: kvmarm@lists.cs.columbia.edu, alex.williamson@redhat.com, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, agraf@suse.de, B08248@freescale.com, tech@virtualopensystems.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 2 Dec 2013 14:56:58 +0100
Antonios Motakis <a.motakis@virtualopensystems.com> wrote:

> VFIO for platform is still under development, and cannot be used yet
> to fully assign a device. However, looking at the example you ran, I
> would not have expected it to fail so spectacularly, so this is
> definitely something I will investigate for our next update to the

it fails in executing this call in vfio-correctness-tests.c [1]:

ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU);

> patch series. Thanks for pointing this out. I plan to release an
> updated series with several improvements and fixes soon enough.

may I ask how you test the patchseries currently?  If on arndale, any
particular device?  Also, I'm assuming you're using a different
userspace test than Alex Williamson's vfio-tests?

Kim

[1] git://github.com/awilliam/tests.git
