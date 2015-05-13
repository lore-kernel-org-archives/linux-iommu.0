From: "Li, ZhenHua" <zhen-hual@hp.com>
Subject: Re: [PATCH v11 07/10] iommu/vt-d: enable kdump support in iommu module
Date: Wed, 13 May 2015 10:28:04 +0800
Message-ID: <5552B6B4.5080206@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com> <1431337974-545-8-git-send-email-zhen-hual@hp.com> <20150513021027.GA3736@dhcp-128-28.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20150513021027.GA3736@dhcp-128-28.nay.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org, vgoyal@redhat.com, dyoung@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, alex.williamson@redhat.com, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com, li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com, rwright@hp.com, "Li, ZhenHua" <zhen-hual@hp.com>
List-Id: iommu@lists.linux-foundation.org

>> +static u8 g_translation_pre_enabled;
> Hi Zhenhua,
>
> I haven't checked patch one by one, am going through the code flow.
>
> About g_translation_pre_enabled, I don't think it's necessary to define
> it as a global variable. Both its assignment and judgement are in
> init_dmars(). In this situation a local variable translation_pre_enabled
> in init_dmars() is enough.
>
> You can assign value to it here:
>
> 		iommu_check_pre_te_status(iommu);
> 		if (iommu->pre_enabled_trans) {
> 			translation_pre_enabled = 1;
> 			...
> 		}
>
> Thanks
> Baoquan
>
Hi Baoquan,
This variable is only be used in this file, for it is defined as static.
Till now, I think both global and local variable are fine, got the same
thing.
But I believe global is better, because if other functions want to know 
whether translation is enabled, this global variable is a good choice.

Thanks
Zhenhua
