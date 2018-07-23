From: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: convert parisc to the generic dma-noncoherent code
Date: Mon, 23 Jul 2018 07:46:17 +0200
Message-ID: <243f489e-bff9-8e09-7f53-a64bd4b1465e@gmx.de>
References: <20180619070455.26624-1-hch@lst.de> <20180711153445.GC31946@lst.de>
	<e2b653d8-cc04-7a81-89a0-9d286c5cc0ca@gmx.de>
	<e29f9140-0d47-e074-1609-d6ae8f8869b3@bell.net>
	<20180717131952.GF13582@lst.de>
	<c080d766-5b7b-2776-848c-60da09bd2c9c@gmx.de>
	<20180722195722.GA10147@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180722195722.GA10147-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 22.07.2018 21:57, Christoph Hellwig wrote:
> On Sun, Jul 22, 2018 at 05:45:40PM +0200, Helge Deller wrote:
>> Somehow I now can't reproduce the cache issues any longer. Both, your original
>> patch and when using flush_kernel_vmap_range(), both work.
>>
>> So, you can add a 
>> Tested-by: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
>> to your original patch series.
> 
> I can merge this through the dma-mapping tree, but given that
> it touches only arch/parisc/ it might make more sense to merge it
> through the parisc tree.

Sure, I will take it through the parisc tree.

Thanks!
Helge
