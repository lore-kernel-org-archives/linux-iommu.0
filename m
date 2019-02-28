From: Joerg Roedel <joro@8bytes.org>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Thu, 28 Feb 2019 14:40:29 +0100
Message-ID: <20190228134029.GC1594@8bytes.org>
References: <CAKxU2N8ioMszBCyQcH7CVhgBdW4aj7yZ+kYQe14DCV5OSAnxrg@mail.gmail.com>
 <20190115090400.GA2267@localhost.localdomain>
 <20190218143742.GA11872@redhat.com>
 <20190226100535.GA20740@8bytes.org>
 <20190226103450.GA2989@redhat.com>
 <20190226104413.GH20740@8bytes.org>
 <20190226112407.GB2989@redhat.com>
 <20190228090411.GA24938@redhat.com>
 <20190228104223.GA2749@redhat.com>
 <20190228121948.GD6072@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228121948.GD6072@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Rosen Penev <rosenp@gmail.com>, linux-wireless <linux-wireless@vger.kernel.org>, Samuel Sieb <samuel@sieb.net>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 28, 2019 at 01:19:48PM +0100, Stanislaw Gruszka wrote:
> Nevermind, the patch is wrong, s->dma_address is initalized in sg_num_pages().

Yes, it is. In sg_num_pages() the offset into the IOMMU mapping is
stored in s->dma_address, taking also the segment boundary mask into
account. map_sg() later only adds the base-address to that.

Regards,

	Joerg
