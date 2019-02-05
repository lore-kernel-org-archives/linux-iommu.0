From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iommu: Allow io-pgtable to be used outside of
 drivers/iommu/
Date: Tue, 5 Feb 2019 08:55:28 -0800
Message-ID: <20190205165528.GA20157@infradead.org>
References: <20190205163731.17864-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190205163731.17864-1-robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 05, 2019 at 10:37:31AM -0600, Rob Herring wrote:
> Move io-pgtable.h to include/linux/ and export alloc_io_pgtable_ops
> and free_io_pgtable_ops. This enables drivers outside drivers/iommu/ to
> use the ARM page table library. Specifically, some ARM Mali GPUs use the
> ARM page table formats.

Maybe rename it to arm-io-pgtable.h to make the usage a little more
clear? 
