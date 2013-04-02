From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Tue, 2 Apr 2013 18:04:00 +0200
Message-ID: <20130402160400.GP30540@8bytes.org>
References: <1364428283-2548-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130402143335.GB15687@8bytes.org> <20130402144037.GE5488@pd.tnic>
	<20130402150302.GF15687@8bytes.org> <20130402152956.GE4391@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130402152956.GE4391-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 02, 2013 at 05:29:56PM +0200, Borislav Petkov wrote:
> On Tue, Apr 02, 2013 at 05:03:04PM +0200, Joerg Roedel wrote:

> Good luck trying to get ASUS to fix anything in their BIOS :(.

Hmm...

> Can't we detect the SB IOAPIC some other way in this case?

I can certainly write a patch that works around your particular BIOS
bug. The problem is that such a fix will most certainly break other
systems.

Unfortunatly there is no reliable way to fixup the IO-APIC-ID->DEVID
mapping at runtime when the BIOS messed it up. The only thing I can do
is to check for potential problems and disable the intremap feature
then, so that the system will at least boot.


	Joerg
