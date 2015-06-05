From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v9 0/9] Add VT-d Posted-Interrupts support - IOMMU part
Date: Fri, 5 Jun 2015 13:47:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506051343510.7723@nanos>
References: <1433482974-14614-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433482974-14614-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>
Cc: joro@8bytes.org, dwmw2@infradead.org, jiang.liu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 5 Jun 2015, Feng Wu wrote:
> Divide the whole series which contain multiple components into three parts:
> - Prerequisite changes to irq subsystem (already merged in tip tree x86/apic branch)
> - IOMMU part (in this series)

Please add 

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Which tree should this go through? It depends on tip/x86/apic AFAICT,
so we can take it through that, if Joerg provides his ACK.

Thanks,

	tglx
 
