From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/4] iommu: Consolitate ->add/remove_device() calls
Date: Thu, 6 Dec 2018 16:47:09 +0100
Message-ID: <20181206154709.GJ16835@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-3-joro@8bytes.org>
 <3ca13757-edf8-95cb-6316-73d202f97dbf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3ca13757-edf8-95cb-6316-73d202f97dbf@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 05, 2018 at 06:20:50PM +0000, Robin Murphy wrote:
> Is there any good reason to let .add_device/.remove_device be optional
> still? Everyone's implemented them for a while now, and on a practical level
> I don't really see how else we could expect devices to be taken in and out
> of their appropriate groups correctly.

There is probably no reason anymore to keep add_device/remove_device
option. I'll check the users and remove the pointer checks if possible.


Regards,

	Joerg
