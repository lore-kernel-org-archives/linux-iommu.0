From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: convert parisc to the generic dma-noncoherent code
Date: Tue, 17 Jul 2018 15:19:52 +0200
Message-ID: <20180717131952.GF13582@lst.de>
References: <20180619070455.26624-1-hch@lst.de> <20180711153445.GC31946@lst.de>
	<e2b653d8-cc04-7a81-89a0-9d286c5cc0ca@gmx.de>
	<e29f9140-0d47-e074-1609-d6ae8f8869b3@bell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e29f9140-0d47-e074-1609-d6ae8f8869b3-CzeTG9NwML0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>
Cc: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Jul 15, 2018 at 12:29:37PM -0400, John David Anglin wrote:
> On 2018-07-13 4:14 AM, Helge Deller wrote:
>> On 11.07.2018 17:34, Christoph Hellwig wrote:
>>> ping?  Any comments?
>> I applied those 3 patches on top of git head, and booted the
>> 32-bit kernel on a HP 715/64 (PCX-L) and a HP B160L (PCX-L2).
>> On both machines I had problems with those drivers which use
>> DMA (I checked specifically the lasi NIC card, which is the
>> main onboard NIC card in both machines).
>> Getting IP via DHCP was unreliable, pings on the same network
>> to both machines gave lost packets, login via ssh sometimes failed
>> and so on.
>>
>> So, there is definitively some cache-flush missing in this patchset.
> Possibly, the code should use flush_kernel_vmap_range() as it purges the =

> TLB entries used
> for the cache flush.=A0 Some of the routines in pci-dma.c currently use i=
t.

That might be worth a try and is already discussed in my description.

Also it might be good to check that the last patch really is the culprit,
I'm pretty certain it is, but a double check never hurts.
