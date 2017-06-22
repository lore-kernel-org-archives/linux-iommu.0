From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Thu, 22 Jun 2017 11:20:53 +0200
Message-ID: <20170622092053.GV30388@8bytes.org>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
	<1496954035.4188.1.camel@rutgers.edu>
	<1498062018.17007.6.camel@rutgers.edu>
	<bf685f44-019c-4c21-25d4-6a6ea647b7cc@amd.com>
	<1498079371.17007.18.camel@rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498079371.17007.18.camel-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, "Nath,
	Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 21, 2017 at 05:09:31PM -0400, Jan Vesely wrote:
> On Wed, 2017-06-21 at 12:01 -0500, Tom Lendacky wrote:
> > On 6/21/2017 11:20 AM, Jan Vesely wrote:
> > > Hi Arindam,
> > > 
> > > has this patch been replaced by Joerg's "[PATCH 0/7] iommu/amd:
> > > Optimize iova queue flushing" series?
> > 
> > Yes, Joerg's patches replaced this patch.  He applied just the first two
> > patches of this series.
> 
> Joerg's patches applied on top of 4.10.17 do not solve my issue (do I
> need the first two patches of this series?). the machine still hangs on
> boot with a flood of IOMMU wait loop timed out messages.
> 
> on the other hand patch 3/3 v1 applied on top of 4.10.17 fixes the
> problem and the machine boots successfully

Interesting. I did some measurements on the IOTLB flush-rate with my
network load-test. This test is designed to heavily excerise the IOMMU
map/unmap path and thus cause many IOTLB invalidations too.

Results are:

	Current upstream v4.12-rc6:	~147000 flushes/s
	With Toms patches:		  ~5900 flushes/s
	With my patches:		  ~1200 flushes/s

So while Toms patches also get the flush-rate down significantly, it is
even lower with my patches. This indicates that the problem is
triggerable even with low flush rates.

But I have no idea why it still triggers with my patches, but not with
Toms. The approaches follow the same idea of only flushing domains that
have map/unmap operations on them.

I really think we need the patch to blacklist ATS on these GPUs
upstream.

Regards,

	Joerg
