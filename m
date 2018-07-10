From: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
Subject: Re: [PATCH 18/25] MIPS: loongson64: use generic dma noncoherent ops
Date: Tue, 10 Jul 2018 11:02:48 -0700
Message-ID: <20180710180248.ns6x42ibi4mhqoex@pburton-laptop>
References: <20180615110854.19253-1-hch@lst.de>
	<20180615110854.19253-19-hch@lst.de>
	<20180619231925.mgbgc7lfvjqumr7a@pburton-laptop>
	<20180620072328.GA1675@lst.de> <20180710123518.GA1812@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180710123518.GA1812-jcswGhMUV9g@public.gmane.org>
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
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Tue, Jul 10, 2018 at 02:35:18PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 20, 2018 at 09:23:28AM +0200, Christoph Hellwig wrote:
> > No, this is a mixup.  I hadn't noticed one case was 0x0fffffff and
> > the other 0x7fffffff.
> > 
> > Below is the minimal fixup that keeps things as much as it was before.
> 
> IS the rest of the series now ok with you?  Anything else I should
> update?

The rest looked good - I applied the series to mips-next & it's been
sitting in linux-next for a couple of weeks now. Apologies it looks like
I didn't reply to say so!

Thanks,
    Paul
