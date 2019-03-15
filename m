From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Fix a null pointer dereference for ACPI
 devices
Date: Fri, 15 Mar 2019 16:27:48 +0100
Message-ID: <20190315152747.GB16974@8bytes.org>
References: <20190308041210.84518-1-chiu@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308041210.84518-1-chiu@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux@endlessm.com
List-Id: iommu@lists.linux-foundation.org

Hi Chris,

On Fri, Mar 08, 2019 at 12:12:10PM +0800, Chris Chiu wrote:
> On ASUS laptop X512DK with the realtek USB card reader, the NULL
> pointer dereference happens while bringing up the rtsx_usb driver.

Thanks for your patch, but I applied

	https://lore.kernel.org/lkml/1552485204-11381-1-git-send-email-aaron.ma@canonical.com/

instead because it fixes the issue where the NULL-ptr dereference
happens. This also covers all future uses of the match_hid_uid()
function.

Thanks,

	Joerg
