From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] iommu/amd: Add workaround for ERBT1312
Date: Wed, 24 Apr 2013 09:52:40 -0400
Message-ID: <5177E3A8.5020001@redhat.com>
References: <1366009666-44792-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130418160220.GA4153@8bytes.org> <51701B9F.10003@amd.com>
	<20130418162856.GA13891@8bytes.org> <51768B25.1060501@redhat.com>
	<20130424104616.GH17148@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130424104616.GH17148-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/24/2013 06:46 AM, Joerg Roedel wrote:
> On Tue, Apr 23, 2013 at 09:22:45AM -0400, Don Dutile wrote:
>> Given other threads on this mail list (and I've seen crashes with same problem)
>> where this type of logging during a flood of IOMMU errors will lock up the machine,
>> is there something that can be done to break the do-while loop after n iterations
>> have been exec'd, so the kernel can progress during a crash ?
>
> In the case of an IOMMU error flood this loop will only run until the
> event-log/ppr-log overflows. So it should not turn into an endless loop.
>
>
> 	Joerg
>
>
Thanks for verification.
