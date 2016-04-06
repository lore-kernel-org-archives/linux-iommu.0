From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: AMD-Vi regression with PCIe/PCI bridges in 4.4
Date: Wed, 6 Apr 2016 21:55:32 +0200
Message-ID: <570569B4.3030008@ladisch.de>
References: <5700BF69.2080102@ladisch.de> <57038D1F.7040205@ladisch.de>
	<20160405101530.GA4203@suse.de> <5703AEE6.4010304@ladisch.de>
	<5703B1F3.6000505@math.uwb.edu.pl> <5703BA5E.3060005@ladisch.de>
	<1459926391.2346.6.camel@gmail.com> <20160406154729.GD4203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160406154729.GD4203-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Joerg Roedel wrote:
> Maybe I can get one of those cards myself to reproduce it. Can you guys
> send me some more detailed information about the sound cards that cause
> the problems?

Most of the PCIe Xonar cards use the same architecture: a PCI chip and
a PCIe/PCI bridge.  Consider the Asus Xonar DGX, Xonar DSX, or Xonar DX.
(The D2X and STX are way overpriced.)


Regards,
Clemens
