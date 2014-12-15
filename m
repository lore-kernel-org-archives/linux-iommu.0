From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 10/10] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Date: Mon, 15 Dec 2014 20:44:29 +0200
Message-ID: <1521122.WC5DkGVrBt@avalon>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1418602429-11276-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAMuHMdWtkk=Q=Mfcyz03LBzXMuBOr8BZGNyCsQb9bwDty-4OiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdWtkk=Q=Mfcyz03LBzXMuBOr8BZGNyCsQb9bwDty-4OiQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Monday 15 December 2014 14:07:52 Geert Uytterhoeven wrote:
> On Mon, Dec 15, 2014 at 1:13 AM, Laurent Pinchart wrote:
> > Add the seven IPMMU instances found in the r8a7791 to DT with a disabled
> > status.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> The addresses and interrupt numbers look OK to me.
> However, my comment about the "0x800" offset is still valid.
> Shouldn't we have two register blocks, and let the driver use only the
> second one?
> 
> If you ignore, feel free to add my
> Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

I don't want to ignore your comment, but I don't know what to do here :-/ The 
datasheet lacks detailed information about secure vs. non-secure mode and how 
the two register sets are supposed to interoperate and be handled by the 
operating system.

-- 
Regards,

Laurent Pinchart
