From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Ratelimit fault handler
Date: Thu, 17 Mar 2016 13:33:30 -0700
Message-ID: <1458246810.9556.22.camel@perches.com>
References: <20160317200557.29049.32879.stgit@gimli.home>
	 <20160317201225.29049.43163.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160317201225.29049.43163.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org, dwmw2@infradead.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2016-03-17 at 14:12 -0600, Alex Williamson wrote:
> Fault rates can easily overwhelm the console and make the system
> unresponsive.=A0=A0Ratelimit to allow an opportunity for maintenance.
[]
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
[]
> @@ -1602,10 +1602,17 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
> =A0	int reg, fault_index;
> =A0	u32 fault_status;
> =A0	unsigned long flag;
> +	bool ratelimited;
> +	static DEFINE_RATELIMIT_STATE(rs,
> +				=A0=A0=A0=A0=A0=A0DEFAULT_RATELIMIT_INTERVAL,
> +				=A0=A0=A0=A0=A0=A0DEFAULT_RATELIMIT_BURST);

Are these the appropriate limits for dmar?

include/linux/ratelimit.h:#define DEFAULT_RATELIMIT_INTERVAL=A0=A0=A0=A0=
(5 * HZ)
include/linux/ratelimit.h:#define DEFAULT_RATELIMIT_BURST=A0=A0=A0=A0=A0=
=A0=A010
