From: "Maciej W. Rozycki" <macro-8NJIiSa5LzA@public.gmane.org>
Subject: Re: [PATCH 12/25] MIPS: loongson: untangle dma implementations
Date: Wed, 11 Jul 2018 13:46:31 +0100
Message-ID: <alpine.DEB.2.00.1807110407510.30992@tp.orcam.me.uk>
References: <20180525092111.18516-1-hch@lst.de>
	<20180525092111.18516-13-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180525092111.18516-13-hch-jcswGhMUV9g@public.gmane.org>
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

On Fri, 25 May 2018, Christoph Hellwig wrote:

> Only loongson-3 is DMA coherent and uses swiotlb.  So move the dma
> address translations stubs directly to the loongson-3 code, and remove
> a few Kconfig indirections.

 SiByte should too though, at least for those boards, such as the SWARM 
and the BigSur, that can have DRAM over 4GiB (and 32-bit PCI devices 
plugged).

 I never got to have the wiring of swiotlb completed for these boards as 
I got distracted with getting set up to debug a DRAM controller issue 
observed in the form of memory data corruption with the banks fully 
populated (which might have to do something with the parameters of bank 
interleaving enabled in such a configuration, as replacing a single 
module with a smaller-sized one and therefore disabling interleaving, 
which can only work with all modules being the same size, makes the 
problem go away).

 FWIW,

  Maciej
