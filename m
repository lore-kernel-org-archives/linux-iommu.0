From: Federico Vaga <federico.vaga-VIMSii5OdOuonA0d6jMUrA@public.gmane.org>
Subject: Re: IOMMU - DMA debugging
Date: Fri, 11 Aug 2017 11:35:35 +0200
Message-ID: <2354060.VDW3kf4Bxo@harkonnen>
References: <1807773.bRUB8Ke59R@harkonnen>
	<9273b2ab-2648-63f7-fe0f-a4462b4e4062@arm.com>
	<22729074.Vd8Fat30YZ@harkonnen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <22729074.Vd8Fat30YZ@harkonnen>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

just to conclude this issue

On Thursday, July 13, 2017 10:43:27 AM CEST Federico Vaga wrote:
> On Wednesday, July 12, 2017 8:02:42 PM CEST Robin Murphy wrote:
> [...]
> > or alternatively the hardware itself is going wrong somehow (e.g. trying
> > to read a buffer address from an in-memory descriptor, getting back
> > junk, and going downhill from there).
> 
> Probably it worth to have a look there

It was an hardware problem it has been fixed. Now the DMA works with and 
without IOMMU.

Thank you again

-- 
Federico Vaga
http://www.federicovaga.it/
