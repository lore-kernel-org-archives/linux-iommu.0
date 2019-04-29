From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Mon, 29 Apr 2019 13:02:31 +0100
Message-ID: <6d99cda0-b7a9-49f2-fbdb-6563fcdd3309@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-13-hch@lst.de>
 <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de>
 <20190417063358.GA24139@lst.de>
 <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
 <20190418163512.GA25347@lst.de>
 <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
 <20190419082348.GA22299@lst.de>
 <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
 <20190429114918.GB30460@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190429114918.GB30460@lst.de>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 29/04/2019 12:49, Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 11:01:44AM +0100, Robin Murphy wrote:
>> Wouldn't this suffice? Since we also use alloc_pages() in the coherent
>> atomic case, the free path should already be able to deal with it.
>>
>> Let me take a proper look at v3 and see how it all looks in context.
> 
> Any comments on v3?  I've been deferring lots of other DMA work to
> not create conflicts, so I'd hate to miss this merge window.

Ah, I did skim the commits in the branch, but I'll run through again and 
reply on the patches while my head's still in email mode...

Robin.
