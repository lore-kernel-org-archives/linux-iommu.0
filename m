From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v3] iommu/s390: Add support for iommu_device handling
Date: Tue, 15 Aug 2017 18:10:39 +0200
Message-ID: <20170815161039.GH2853@suse.de>
References: <1502274354-643-1-git-send-email-joro@8bytes.org>
	<alpine.LFD.2.20.1708102104390.4919@schleppi>
	<20170811073118.GF30515@8bytes.org>
	<alpine.LFD.2.20.1708111844340.1769@schleppi>
	<20170814162434.GF2853@suse.de>
	<alpine.LFD.2.20.1708151800210.1730@schleppi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1708151800210.1730@schleppi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 15, 2017 at 06:02:20PM +0200, Sebastian Ott wrote:
> On Mon, 14 Aug 2017, Joerg Roedel wrote:
> > I attach the patch I wrote to fix this, can you please test it together
> > with the initial patch in this thread?
> 
> I did and can confirm that everything worked as expected!

Great, thanks a lot for your testing and thanks again for the effort to
root-cause the crashes on s390x.

So, can I add an Acked-by to the initial patch and put it into the
iommu-tree?


Regards,

	Joerg
