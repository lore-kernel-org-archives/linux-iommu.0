From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Date: Thu, 25 Apr 2019 11:41:05 +0100
Message-ID: <fd5b8c6c-05f0-307b-aaa2-0938337014a8@arm.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <4550408f-39ff-7bf9-0072-a0898c6c2f60@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4550408f-39ff-7bf9-0072-a0898c6c2f60@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On 25/04/2019 11:17, Auger Eric wrote:
>> +/**
>> + * ioasid_alloc - Allocate an IOASID
>> + * @set: the IOASID set
>> + * @min: the minimum ID (inclusive)
>> + * @max: the maximum ID (exclusive)
>> + * @private: data private to the caller
>> + *
>> + * Allocate an ID between @min and @max (or %0 and %INT_MAX). Return the
> I would remove "(or %0 and %INT_MAX)".

Agreed, those where the default values of idr, but the xarray doesn't
define a default max value. By the way, I do think squashing patches 6
and 7 would be better (keeping my SOB but you can change the author).

>> +typedef int (*ioasid_iter_t)(ioasid_t ioasid, void *private, void *data);
> I don't see it used in this series.

There used to be a "ioasid_for_each()", which isn't needed by anyone at
the moment. This can be removed.

Thanks,
Jean
