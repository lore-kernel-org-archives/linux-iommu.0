From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Kdump kernel hang when set amd_iommu=off
Date: Wed, 14 Feb 2018 18:07:05 +0800
Message-ID: <20180214100705.GC28659@localhost.localdomain>
References: <20180126080622.GC1759@localhost.localdomain>
	<20180213132520.nqn5osmgsubzjzcq@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180213132520.nqn5osmgsubzjzcq-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 02/13/18 at 02:25pm, Joerg Roedel wrote:
> Hi Baoquan,
> 
> On Fri, Jan 26, 2018 at 04:06:22PM +0800, Baoquan He wrote:
> > Saw Huawei's bug report about kdump kernel hang when intel_iommu=off 
> > is set. I met the similar problem in amd system, only set amd_iommu=off
> > in kdump kernel, it means amd_iommu is on in 1st kernel.
> > 
> > I am reading doc and code, trying to debug. Please help have a look when
> > convenient, see if there's hint or direction.
> 
> Yeah, I know that this is broken on the AMD-IOMMU side. Problem is that
> the IOMMU hardware needs to be disabled in the kdump kernel when
> amd_iommu=off is on the command-line. I'll look into fixing that.

Thanks for looking into this. This was found by our QE, I checked, and
found it only happened on two HPE systems. Other AMD systems have no
such issue. Since it's not a blocker, I just go to fix those urgent
bugs.

> 
> I thought we fixed this a while ago already for VT-d, is it broken
> again?

It's not seen in redhat's test machines, just saw Huawei engineers
reported this issue. They cc-ed lkml.

Thanks
Baoquan
