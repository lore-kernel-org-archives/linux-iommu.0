From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 08/19] iommu: Implement reserved_regions iommu-group
 sysfs file
Date: Tue, 10 Jan 2017 22:21:28 +0100
Message-ID: <1d2137bf-8d0d-d786-6cd6-9090fb76f05c@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-9-git-send-email-eric.auger@redhat.com>
 <9ee5aa6b-6e63-c153-0727-729e0e9592c6@redhat.com>
 <20170110171444.GU17255@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170110171444.GU17255@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, bharat.bhushan@nxp.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, geethasowjanya.akula@gmail.com, diana.craciun@nxp.com, alex.williamson@redhat.com, pranav.sawargaonkar@gmail.com, shankerd@codeaurora.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, gpkulkarni@gmail.com, robin.murphy@arm.com, christoffer.dall@linaro.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,
On 10/01/2017 18:14, Joerg Roedel wrote:
> On Tue, Jan 10, 2017 at 05:20:34PM +0100, Auger Eric wrote:
>> The /sys/kernel/iommu_groups/n directory seems to be removed before this
>> gets called and this may produce a WARNING when devices get removed from
>> the group. I intend to remove the call since I have the feeling
>> everything gets cleaned up properly.
> 
> A feeling is not enough, please check that in the code.

So my understanding is on group's kobject_release we have:
kobject_release
|_ kobject_cleanup
	|_ kobject_del
		|_ sysfs_remove_dir
			|_ kernfs_remove
				|_ _kernfs_remove
	../..
	|_ ktype release (iommu_group_release)

_kernfs_remove() calls kernfs_put() on all descendant nodes, leading to
the whole directory cleanup.

In iommu_group_release I called sysfs_remove_file on the
reserved_regions attribute file. My understanding is its job is
identifical as what was done previously and the node was already
destroyed hence the warning.

sysfs_remove_file
|_ sysfs_remove_file_ns
	|_ kernfs_remove_by_name_ns
		|_kernfs_remove

So my understanding is it is safe to remove it.

Thanks

Eric
> 
> 
> 	Joerg
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
