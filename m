From: "Li, ZhenHua" <zhen-hual@hp.com>
Subject: Re: [PATCH 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Tue, 06 Jan 2015 15:05:46 +0800
Message-ID: <54AB894A.3070601@hp.com>
References: <1419239729-26529-1-git-send-email-zhen-hual@hp.com> <20150106063718.GA2454@dhcp-16-105.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20150106063718.GA2454@dhcp-16-105.nay.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>, indou.takao@jp.fujitsu.com
Cc: dwmw2@infradead.org, joro@8bytes.org, vgoyal@redhat.com, dyoung@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, alex.williamson@redhat.com, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com, li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com
List-Id: iommu@lists.linux-foundation.org

According to Takao Indoh's testing, seems adding flush after loading old 
irte and updating old irte does not fix the dmar faults.

According to Takao Indoh's log and your log, the faults happens while 
and after driver is loaded.  Maybe I am using incorrect code in 08/10.


On 01/06/2015 02:37 PM, Baoquan He wrote:
> Hi Zhenhua,
>
> I just tested your patchset based on 3.19.0-rc2+, and found several dmar
> fault and intr-remap fault, it seems not the same as Takao's, please
> check the attachment.
>
> Thanks
> Baoquan
>
