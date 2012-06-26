From: "Alexandra N. Kossovsky" <Alexandra.Kossovsky-mK/T7fl7eHLILq5++fvS8w@public.gmane.org>
Subject: Re: atomic context for iommu_map call
Date: Tue, 26 Jun 2012 13:08:42 +0400
Message-ID: <20120626090840.GA8140@oktetlabs.ru>
References: <20120622112812.GV8140@oktetlabs.ru>
	<20120626085853.GX2624@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120626085853.GX2624-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robert Stonehouse <rstonehouse-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 26, 2012 at 10:58:53AM +0200, Joerg Roedel wrote:
> On Fri, Jun 22, 2012 at 03:28:14PM +0400, Alexandra N. Kossovsky wrote:
> > We use IOMMU API in OpenOnload project http://www.openonload.org/,
> > and we get better latency with Intel IOMMU because we are not
> > forced to use threaded IRQ.
> 
> Yes, the IRQ for the AMD IOMMU is threaded. But I don't understand how
> that is relevant for your latency. Can you give more details here?

We have PCI VF used for accelerated networking in OpenOnload.  This PCI
VF has an IRQ handler, which calls iommu_map.  For Intel IOMMU, we have
used non-threaded IRQ handler, and it shows pretty good latency for
network applications accelerated with OpenOnload.  When AMD IOMMU is in
use, we are forced to use threaded IRQ handler for our PCI VF; network
latency is worse.

I.e. we do not care that "IRQ for the AMD IOMMU is threaded".  We care
that we have to use threaded IRQ for our PCI VFs.

-- 
Alexandra N. Kossovsky
OKTET Labs (http://www.oktetlabs.ru/)
