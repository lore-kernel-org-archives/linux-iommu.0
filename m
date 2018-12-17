From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/6] driver core: Introduce device_iommu_mapped() function
Date: Mon, 17 Dec 2018 11:41:10 +0530
Message-ID: <20181217061110.GC2472@vkoul-mobl>
References: <20181211134343.10664-1-joro@8bytes.org>
 <20181211134343.10664-2-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211134343.10664-2-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Dan Williams <dan.j.williams@intel.com>, jroedel@suse.de, Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 11-12-18, 14:43, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Some places in the kernel check the iommu_group pointer in
> 'struct device' in order to find ot whether a device is
                                   ^^
Typo
-- 
~Vinod
