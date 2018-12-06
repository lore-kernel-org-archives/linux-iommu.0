From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/5] driver core: Introduce device_iommu_mapped() function
Date: Thu, 6 Dec 2018 13:55:20 +0100
Message-ID: <20181206125520.GA28736@kroah.com>
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-2-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204172504.19708-2-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 04, 2018 at 06:25:00PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Some places in the kernel check the iommu_group pointer in
> 'struct device' in order to find ot whether a device is
> mapped by an IOMMU.
> 
> This is not good way to make this check, as the pointer will
> be moved to 'struct dev_iommu_data'. This way to make the
> check is also not very readable.
> 
> Introduce an explicit function to perform this check.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/device.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
