From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 03/16] iommu: introduce iommu invalidate API function
Date: Wed, 11 Oct 2017 14:15:34 +0200
Message-ID: <20171011121534.GG30803@8bytes.org>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1507244624-39189-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20171010133542.juag7cwbivlb56sl@8bytes.org>
 <20171010150953.4095a045@jacob-builder>
 <A2975661238FB949B60364EF0F2C257439AF5F37@SHSMSX104.ccr.corp.intel.com>
 <20171011095126.GD30803@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439AF61F5@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439AF61F5@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 11, 2017 at 11:54:52AM +0000, Liu, Yi L wrote:
> I didn't quite get 'iovm' mean. Can you explain a bit about the idea?

It's short for IO Virtual Memory, basically a replacement term for 'svm'
that is not ambiguous (afaik) and not specific to Intel.


	Joerg
