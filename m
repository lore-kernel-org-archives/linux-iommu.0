From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 0/3] iommu/amd: Enable x2APIC support
Date: Wed, 27 Jun 2018 11:29:05 +0200
Message-ID: <20180627092905.7lgcp3iu5ijzslcw@suse.de>
References: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

Hey Suravee,

On Fri, Jun 22, 2018 at 12:02:04PM -0500, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (3):
>   x86: irq_remapping: Move irq remapping mode enum
>   iommu/amd: Add support for higher 64-bit IOMMU Control Register
>   iommu/amd: Add support for IOMMU XT mode

The patches look good to me, please include the fix for the kbuild-bot
report and re-send.


Thanks,

	Joerg
