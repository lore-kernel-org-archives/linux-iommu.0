From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Fri, 8 Dec 2017 13:52:00 +0000
Message-ID: <b0976bc9-68c8-f5c9-881b-5913a4ca1970@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
 <20171204133715.50c45136@jacob-builder>
 <a6cfc27a-6121-1e67-6e0d-f94a383bcd6f@arm.com>
 <20171206112521.1edf8e9b@jacob-builder> <20171207145121.23b3f26f@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207145121.23b3f26f@t450s.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Jean Delvare <khali@linux-fr.org>, Will Deacon <Will.Deacon@arm.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
List-Id: iommu@lists.linux-foundation.org

On 07/12/17 21:51, Alex Williamson wrote:
>> Agree, IOMMU driver cannot enforce it. I think VFIO layer can make sure
>> page response come from the assigned device and its guest/container.
> 
> Can we enforce it via the IOMMU/VFIO interface?  If the response is for
> a struct device, and not an rid/did embedded in a structure, then vfio
> can pass it through w/o worrying about it, ie. response comes in via
> ioctl with association to vfio device fd -> struct vfio_device -> struct
> device, iommu driver fills in rid/did.  Thanks,

Yes that's probably the best way, reporting faults and receiving responses
on the device fd.

Thanks,
Jean
