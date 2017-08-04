From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 05/13] iommu/amd: Add function copy_dev_tables()
Date: Fri, 4 Aug 2017 21:00:46 +0800
Message-ID: <20170804130046.GL1874@x1>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
	<1501587449-9817-6-git-send-email-bhe@redhat.com>
	<20170804120908.GT3431@suse.de> <20170804123039.GK1874@x1>
	<20170804125159.GY3431@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170804125159.GY3431-l3A5Bk7waGM@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 08/04/17 at 02:51pm, Joerg Roedel wrote:
> On Fri, Aug 04, 2017 at 08:30:39PM +0800, Baoquan He wrote:
> > Sorry, I don't get 'this one' meaning, are you suggesting the copy for
> > loop should be take out of the iommu for loop? 
> > 
> > About the temporary copy of the old device-table, you can see in patch
> > 7/13, if irq sanity check failed, it return -1. This return could happen
> > in the middle of copy. So I think we should do a whole successful copy,
> > or don't copy at all. It might not be good do half copy.
> 
> No, I mean that you should move the copy of the complete device-table
> out of the for_each_iommu() loop. Currently you make sure you copy only
> once with the 'copied' flag, but that is not necessary if you move the
> code behind the loop.

Ok, will do. Thanks!
> 
