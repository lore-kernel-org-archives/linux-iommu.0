From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Date: Thu, 22 Nov 2018 07:16:32 -0800
Message-ID: <20181122151632.GP3065@bombadil.infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122023558.GO3065@bombadil.infradead.org>
 <20181122082602.GB2049@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181122082602.GB2049@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Pekka Enberg <penberg@kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Huaisheng Ye <yehs1@lenovo.com>, Tomasz Figa <tfiga@google.com>, Mel Gorman <mgorman@techsingularity.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Nicolas Boichat <drinkcat@chromium.org>, linux-arm-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Christopher Lameter <cl@linux.com>, Robin Murphy <robin.murphy@arm.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 22, 2018 at 12:26:02AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 21, 2018 at 06:35:58PM -0800, Matthew Wilcox wrote:
> > I think you should look at using the page_frag allocator here.  You can
> > use whatever GFP_DMA flags you like.
> 
> So I actually tries to use page_frag to solve the XFS unaligned kmalloc
> allocations problem, and I don't think it is the right hammer for this
> nail (or any other nail outside of networking).
> 
> The problem with the page_frag allocator is that it never reuses
> fragments returned to the page, but only only frees the page once all
> fragments are freed.  This means that if you have some long(er) term
> allocations you are effectively creating memory leaks.

Yes, your allocations from the page_frag allocator have to have similar
lifetimes.  I thought that would be ideal for XFS though; as I understood
the problem, these were per-IO allocations, and IOs to the same filesystem
tend to take roughly the same amount of time.  Sure, in an error case,
some IOs will take a long time before timing out, but it should be OK
to have pages unavailable during that time in these rare situations.
What am I missing?
