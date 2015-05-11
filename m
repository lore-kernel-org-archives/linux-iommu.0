From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: PROBLEM: Deadlock in attach_device() in AMD IOMMU driver
Date: Mon, 11 May 2015 12:15:29 +0200
Message-ID: <20150511101528.GI20611@8bytes.org>
References: <55488C3D.50509@solarflare.com> <20150505144159.GI15736@8bytes.org>
	<5548D814.6020807@solarflare.com>
	<20150505153344.GR15736@8bytes.org>
	<5549FEA1.9080801@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5549FEA1.9080801-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kieran Mansley <kmansley-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Gregor,

On Wed, May 06, 2015 at 12:44:33PM +0100, Gregor Dick wrote:
> On 05/05/15 16:33, Joerg Roedel wrote:
> >Okay, I'll have a look into the SLES12 kernel sources to check there.
> >Can you reproduce this with a recent upstream kernel?
> 
> I've done some more tests this morning and can reproduce the problem on
> a vanilla 4.0 kernel with a SLES12 userland, and also on a stock
> installation of Ubuntu 14.10 with a 3.16-derived kernel.
> 
> I neglected to mention kernel command-line options earlier:

Thanks for testing this, I will work on a fix.


	Joerg
