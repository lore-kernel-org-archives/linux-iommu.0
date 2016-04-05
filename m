From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: AMD-Vi regression with PCIe/PCI bridges in 4.4
Date: Tue, 5 Apr 2016 15:19:29 +0200
Message-ID: <20160405131928.GJ17838@8bytes.org>
References: <5700BF69.2080102@ladisch.de> <57038D1F.7040205@ladisch.de>
	<20160405101530.GA4203@suse.de> <5703AEE6.4010304@ladisch.de>
	<5703B1F3.6000505@math.uwb.edu.pl> <5703BA5E.3060005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5703BA5E.3060005-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Tomasz Golinski <tomaszg-FRiIMV821htubak7+UBa2Q@public.gmane.org>, bellamorte42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, martin <haiden.tracking-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 05, 2016 at 03:15:10PM +0200, Clemens Ladisch wrote:
> Tomasz Golinski wrote:
> > On 05.04.2016 14:26, Clemens Ladisch wrote:
> >> Martin/Tomasz, could we get the amd_iommu_dump dmesg output for an
> >> earlier kernel?
> >
> > It's for 4.1.15.
> > ...
> > [    0.486934] AMD-Vi:   DEV_SPECIAL(IOAPIC[5])		devid: 00:14.0
> > [    0.569054] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
> 
> All those "iommu: Adding device x to group y" messages from 4.4 are
> missing.

Yeah, these messages got added in v4.2.



	Joerg
