From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC v2] dma-mapping: Use unsigned long for dma_attrs
Date: Wed, 1 Jun 2016 00:51:42 -0700
Message-ID: <20160601075142.GA1700@infradead.org>
References: <1464609246-6948-1-git-send-email-k.kozlowski@samsung.com>
 <1464609246-6948-2-git-send-email-k.kozlowski@samsung.com>
 <20160531170420.GB25366@infradead.org>
 <574E746A.2030806@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <574E746A.2030806@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, sstabellini@kernel.org, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 01, 2016 at 07:36:42AM +0200, Krzysztof Kozlowski wrote:
> > No really for this patch, but I would much prefer to document them next
> > to the code in the long run.  Also I really think these BIT() macros
> > are a distraction compared to the (1 << N) notation.
> 
> Not much difference to me but maybe plain number:
> ...	0x01u
> ...	0x02u
> ?

I prefer the little bit shifts, but even the explicit values are much
better than the obsfucating macros :)  Anyway, your patch and in the end
all three methods will get the work done.

> > I'd just kill this helper, much easier to simply open code it in the
> > caller.
> 
> Keeping it for now helps reducing the number of changes in the patch.
> The patch will be quite big as it has to replace all the uses atomically.
> 
> I can get rid of the helper in consecutive patch.

Sounds fine.
