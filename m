From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: AMD IOMMU: Please support Marvell 88SE91xx SATA Controllers
Date: Tue, 30 Jul 2013 13:39:54 +0200
Message-ID: <20130730113954.GK28811@8bytes.org>
References: <519A93F0.8070606@gmx.ch> <20130521203526.GE7424@8bytes.org>
	<51D3E691.8030307@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51D3E691.8030307-OI3hZJvNYWs@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Manfred Schwarb <manfred99-OI3hZJvNYWs@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Andrew,

On Wed, Jul 03, 2013 at 10:53:37AM +0200, Manfred Schwarb wrote:
> Am 21.05.2013 22:35, schrieb Joerg Roedel:
> >On Mon, May 20, 2013 at 11:21:52PM +0200, Manfred Schwarb wrote:
> >>Is anybody working on this issue for the AMD part? I would be very
> >>grateful if such support could be added to the linux kernel. I would
> >>be prepared to test patches, if needed.

Somehow the workaround for Intel didn't make it upstream. Do you plan to
continue working on the workaround?

I reused a few parts of your VT-d patch to implement the workaround for
AMD, there is surely potential to have some common code between the
IOMMU drivers for this.


	Joerg
