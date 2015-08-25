From: "Xiao, Nan (Nan@HPservers-Core-OE-PSC)" <nan.xiao-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [PATCH] Documentation/Intel-IOMMU.txt: Modify definition of DRHD
Date: Tue, 25 Aug 2015 09:04:49 +0000
Message-ID: <F9D82F0D71C0024FA18FE771EDDAF1490820210B@G4W3298.americas.hpqcorp.net>
References: <F9D82F0D71C0024FA18FE771EDDAF149081FAC82@G4W3303.americas.hpqcorp.net>
	<20150825085148.GC32055@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150825085148.GC32055-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Firstly, thanks very much for your detailed comments!

I first send this patch to linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org only (the result of get_maintainer.pl ), but after about 3
days, there is no any responses. I thought no one would notice this bug, so I resend the patch to you. But this
morning, Jonathan confirmed he has merged the patch (https://lkml.org/lkml/2015/8/24/637) , so I think maybe 
there is no need for you to merge it again.

I am very sorry for not updating the information immediately! Thanks for your understanding!

Best Regards
Nan Xiao

-----Original Message-----
From: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org] 
Sent: Tuesday, August 25, 2015 4:52 PM
To: Xiao, Nan (Nan@HPservers-Core-OE-PSC)
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Subject: Re: [PATCH] Documentation/Intel-IOMMU.txt: Modify definition of DRHD

Hi Nan,

I applied this patch with some formatting fixes, thanks. Details below:

From: "Xiao, Nan (Nan@HPS Performance, Beijing)" <nan.xiao-VXdhtT5mjnY@public.gmane.org>

git-am made this author-line out of your patch: "(Nan@HPS <(Nan@HPS>"

Which doesn't even look like a valid email address. I fixed it, but please include a From: line in your future patches like this:

From: Xiao, Nan <nan.xiao-VXdhtT5mjnY@public.gmane.org>

This will guarantee that your patches will be accounted correctly.

Next is the patch subject. For iommu patches please use a prefix like
this: <arch>/<iommu>

In case of Intel VT-d this would look like "iommu/vt-d:", and my updated subject line looks like:

Subject: x86/vt-d: Fix documentation of DRHD

On Mon, Aug 24, 2015 at 06:22:42AM +0000, Xiao, Nan (Nan@HPS Performance, Beijing) wrote:
> According to "Intel Virtualization Technology for Directed I/O" 
> specification, DRHD stands for "DMA Remapping Hardware Unit Definition" , not "DMA Engine Reporting Structure".

These lines are too long. Please try to limit the line-length in patches to 60 characters for iommu patches.


Thanks,

	Joerg
