From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCHv2 0/3] Support for nesting IOMMUs in VFIO
Date: Wed, 09 Jul 2014 14:37:15 -0600
Message-ID: <1404938235.4256.199.camel@ul30vt.home>
References: <1404930526-32119-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404930526-32119-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2014-07-09 at 19:28 +0100, Will Deacon wrote:
> Hello,
> 
> This is v2 of the RFC I originally posted here:
> 
>  RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552
> 
> It's changed significantly since then, based on helpful feedback from
> Alex. In particular, I no longer butcher the IOMMU API, instead making
> use of a new iommu_attr to indicate that a domain requires support for
> nesting.
> 
> All feedback welcome (this is still an RFC after all),

Hi Will,

It's a lot cleaner this way, but I'm concerned that allowing a "nesting"
IOMMU to be created and used just like a TYPE1v2 IOMMU, even if the
IOMMU doesn't support it, puts us in a corner for compatibility later.
The safer approach might be to fail the attach_group function if we
can't set the domain attribute, ie. enforce that the IOMMU must support
it.  I don't know how you'd handle it if only some of the domains within
a container supported it, so enforcement may simplify things down the
road too.  We wouldn't need the vfio_domains_have_iommu_nesting()
function that way either.  Thanks,

Alex
