From: Christoph Hellwig <hch@lst.de>
Subject: Re: don't pass a NULL struct device to DMA API
 functions
Date: Fri, 1 Feb 2019 17:09:57 +0100
Message-ID: <20190201160957.GD6532@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <s5ho97v8x9j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5ho97v8x9j.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, iommu@lists.linux-foundation.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Vinod Koul <vkoul@kernel.org>, netdev@vger.kernel.org, John Crispin <john@phrozen.org>, dmaengine@vger.kernel.org, linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 02:16:08PM +0100, Takashi Iwai wrote:
> Actually there are a bunch of ISA sound drivers that still call
> allocators with NULL device.
> 
> The patch below should address it, although it's only compile-tested.

Oh, I missed these "indirect" calls.  This looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
