From: Christoph Hellwig <hch@lst.de>
Subject: Re: ARM64 boot failure on espressobin with 5.0.0-rc6
 (1f947a7a011fcceb14cb912f5481a53b18f1879a)
Date: Thu, 14 Feb 2019 18:36:42 +0100
Message-ID: <20190214173642.GA2704@lst.de>
References: <bd202e22-c23e-ddf1-ef33-e60896465a5a@bell.net>
 <6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, John David Anglin <dave.anglin@bell.net>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 14, 2019 at 05:27:41PM +0000, Robin Murphy wrote:
> Oh wow, that driver has possibly the most inventive way of passing a NULL 
> device to the DMA API that I've ever seen, and on arm64 it will certainly 
> have been failing since 4.2, but of course there's also no error checking 
> for anyone to notice...

I did take a brief look and didn't see how we got the NULL device
pointer, so it is well hidden for sure.

> This crash will be a fallout from 356da6d0cd (plus the subsequent fix in 
> 9ab91e7c5c51) that's otherwise missed Christoph's big cleanup. Obviously 
> the right thing to do is for someone to try to figure out the steaming pile 
> of mess in that driver, but if necessary I think the quick fix below should 
> probably suffice to mitigate the change in the short term.

The fix looks ok.  And for 5.2 I plan to explicitly reject all uses of
NULL device arguments in the DMA API.  I've sent patches out for all
the obviously problemetic drivers, and most of them got accepted by the
maintainers for the 5.1 merge window.

It seems like the mv_xor code is mostly unmaintained as far as I can
tell unfortunately.
