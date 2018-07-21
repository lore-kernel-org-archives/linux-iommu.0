From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: use the generic dma-noncoherent code for openrisc
Date: Sat, 21 Jul 2018 14:37:08 +0200
Message-ID: <20180721123708.GA635@lst.de>
References: <20180719130232.1819-1-hch@lst.de>
	<20180721053142.GC9742@lianli.shorne-pla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180721053142.GC9742-Uk7Bhu+bUQgm0WYXfsLZQReHL2rgt/dS@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stafford Horne <shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Kristiansson <stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jul 21, 2018 at 02:31:42PM +0900, Stafford Horne wrote:
> For upstreaming, do you want me to send these through the openrisc tree, or do
> you want to send with the dma tree?

Feel free to merge them through the openrisc tree.
