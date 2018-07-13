From: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: convert parisc to the generic dma-noncoherent code
Date: Fri, 13 Jul 2018 10:14:38 +0200
Message-ID: <e2b653d8-cc04-7a81-89a0-9d286c5cc0ca@gmx.de>
References: <20180619070455.26624-1-hch@lst.de> <20180711153445.GC31946@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180711153445.GC31946-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11.07.2018 17:34, Christoph Hellwig wrote:
> ping?  Any comments?

I applied those 3 patches on top of git head, and booted the
32-bit kernel on a HP 715/64 (PCX-L) and a HP B160L (PCX-L2).
On both machines I had problems with those drivers which use
DMA (I checked specifically the lasi NIC card, which is the 
main onboard NIC card in both machines).
Getting IP via DHCP was unreliable, pings on the same network 
to both machines gave lost packets, login via ssh sometimes failed
and so on.

So, there is definitively some cache-flush missing in this patchset.

I'm happy to test any further patches, but I'l be blocked at least
until end of next week. It would be good if James could do some 
testing on his PCX-machine too, since that machine is different
than mine.

Thanks for your efforts to clean that up!
Helge

> On Tue, Jun 19, 2018 at 09:04:52AM +0200, Christoph Hellwig wrote:
>> This should address all the comments raised last time.
For the record: Here is the link to the patchbundle:
https://patchwork.kernel.org/bundle/helge/DMA_OP/
