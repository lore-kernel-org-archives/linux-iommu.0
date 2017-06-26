From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Suppress IO_PAGE_FAULTs in kdump kernel
Date: Mon, 26 Jun 2017 18:25:39 +0800
Message-ID: <20170626102539.GA20825@x1>
References: <1497600901-8993-1-git-send-email-joro@8bytes.org>
	<20170623085719.GD20618@x1> <20170623114310.GE20618@x1>
	<20170626100742.GC3737@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170626100742.GC3737-l3A5Bk7waGM@public.gmane.org>
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

On 06/26/17 at 12:07pm, Joerg Roedel wrote:
> Hi Baoquan,
> 
> On Fri, Jun 23, 2017 at 07:43:10PM +0800, Baoquan He wrote:
> > Do you think whether it's necessary to continue my kdump fix of amd iommu
> > patchset? Seems my last post was in Jan this year. I know you are very
> > busy on fixing bugs and reviewing tons of patches. Without your
> > guidance and reviewing, I absolutely can't make it. So I would like to
> > hear your suggestions and idea.
> > 
> > I focused on kaslr issues recently, now most of them have been
> > fixed. My boss discussed with me about the next plan. If you have other
> > plan, I can sync it to our team about the status of upstream.
> 
> Sorry for my silence on the patches, I have not yet found the time to
> look deeply into them. I am still interested in them, so how about you
> do a rebase/repost after the next merge window and then I will take the
> time for a more in depth review and discussion?

Thanks a lot for reply. Totally understood, so many patches need be
reviewed, and so many different iommu types.

Sure, let me do it right away. I may need a little time to recall the
details, go through the spec and code again. It won't take too long.

Thanks
Baoquan
> 
