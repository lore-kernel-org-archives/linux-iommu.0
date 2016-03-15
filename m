From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] iommu/vt-d: Ratelimit fault handler
Date: Tue, 15 Mar 2016 11:01:12 -0700
Message-ID: <1458064872.11972.195.camel@perches.com>
References: <20160315163503.2875.49980.stgit@gimli.home>
	 <1458061851.11972.193.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458061851.11972.193.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org, dwmw2@infradead.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2016-03-15 at 10:10 -0700, Joe Perches wrote:
> o Use a single ratelimit state.
[]
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
[]
> +	if (__ratelimit(&rs))
> +		return 0;

That of course should be:

	if (!__ratelimit(&rs))
		return 0;
