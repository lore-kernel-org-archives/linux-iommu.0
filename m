From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Date: Wed, 24 Apr 2019 17:55:06 +0200
Message-ID: <20190424155505.GA6731@8bytes.org>
References: <20190424141900.8883-1-tmurphy@arista.com>
 <20190424143246.GA24079@infradead.org>
 <CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
 <20190424145819.GA16141@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424145819.GA16141@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 24, 2019 at 07:58:19AM -0700, Christoph Hellwig wrote:
> I'd be tempted to do that.  But lets just ask Joerg if he has
> any opinion..

The reason was that it is an unlikely path, as hardware implementations
are not allowed to set this bit. It is purely for emulated AMD IOMMUs.
I have not measured whether this annotation has any performance
benefit, but I find it more readable at least.

Regards,

	Joerg

PS: Why did you drop me from the Cc list of the previous replies?
