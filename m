From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v7 08/19] iommu: Implement reserved_regions iommu-group
 sysfs file
Date: Tue, 10 Jan 2017 18:14:44 +0100
Message-ID: <20170110171444.GU17255@8bytes.org>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-9-git-send-email-eric.auger@redhat.com>
 <9ee5aa6b-6e63-c153-0727-729e0e9592c6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9ee5aa6b-6e63-c153-0727-729e0e9592c6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com, gpkulkarni@gmail.com, shankerd@codeaurora.org, bharat.bhushan@nxp.com, geethasowjanya.akula@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 10, 2017 at 05:20:34PM +0100, Auger Eric wrote:
> The /sys/kernel/iommu_groups/n directory seems to be removed before this
> gets called and this may produce a WARNING when devices get removed from
> the group. I intend to remove the call since I have the feeling
> everything gets cleaned up properly.

A feeling is not enough, please check that in the code.


	Joerg
