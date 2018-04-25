From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 5/5] ARM: Unconditionally enable ARM_DMA_USE_IOMMU
Date: Wed, 25 Apr 2018 08:17:45 -0700
Message-ID: <20180425151745.GA16075@infradead.org>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-5-thierry.reding@gmail.com>
 <20180425102511.GP16141@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180425102511.GP16141@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: nouveau@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 25, 2018 at 11:25:11AM +0100, Russell King - ARM Linux wrote:
> >  config ARM_DMA_USE_IOMMU
> > -	bool
> > +	def_bool y
> >  	select ARM_HAS_SG_CHAIN
> >  	select NEED_SG_DMA_LENGTH
> 
> This doesn't work - as has recently been discussed with hch, we can't
> globally enable NEED_SG_DMA_LENGTH on ARM - the ARM architecture
> pre-dates the addition of the DMA length member in the scatterlist,
> and not every machine supports the splitting of the DMA length from
> the non-DMA length member.  Hence, this will cause a regression,
> sorry.

Agreed as-is.  However supporting it everywhere should not be much work,
I'll take a look at it.
