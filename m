From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [Patch v2 00/16] Refine IR initialization flow and fixes bugs
 related to X2APIC
Date: Fri, 9 Jan 2015 13:03:21 +0100
Message-ID: <20150109120321.GA17298@8bytes.org>
References: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 07, 2015 at 03:31:27PM +0800, Jiang Liu wrote:
> This patch set is based on v3.19-rc3. And you may access it at:
> https://github.com/jiangliu/linux.git ir_init_v2

I tested this branch on an AMD system, everything looks good so far. I
couldn't find any regressions. So feel free to add my

Tested-by: Joerg Roedel <jroedel@suse.de>


Regards,

	Joerg
