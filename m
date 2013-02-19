From: Diana Craciun <diana.craciun@freescale.com>
Subject: Re: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Tue, 19 Feb 2013 12:04:23 +0200
Message-ID: <51234E27.9020604@freescale.com>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com> <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, scottwood@freescale.com, joro@8bytes.org, stuart.yoder@freescale.com
List-Id: iommu@lists.linux-foundation.org

On 02/18/2013 02:52 PM, Varun Sethi wrote:
> +
> +#define PAACE_TCEF_FORMAT0_8B   0x00
> +#define PAACE_TCEF_FORMAT1_RSVD 0x01
> +
> +#define PAACE_NUMBER_ENTRIES    0x1FF

Where is this number coming from?

Diana
