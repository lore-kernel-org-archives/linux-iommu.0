From: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: Add iommu_fault class event to iommu trace
Date: Tue, 24 Sep 2013 06:39:49 -0600
Message-ID: <52418815.20701@samsung.com>
References: <cover.1376672275.git.shuah.kh@samsung.com>
	<7a14c27d8341e53f2aed7b80e08a4480d89eac5e.1376672275.git.shuah.kh@samsung.com>
	<20130924104855.GB4532@8bytes.org>
Reply-To: shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20130924104855.GB4532-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, udknight-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/24/2013 04:48 AM, Joerg Roedel wrote:
> On Fri, Aug 16, 2013 at 11:20:16AM -0600, Shuah Khan wrote:
>> +DEFINE_EVENT(iommu_fault, report_fault,
>> +
>> +	TP_PROTO(struct device *dev, unsigned long iova, int flags),
>> +
>> +	TP_ARGS(dev, iova, flags)
>> +);
>
> I am not entirely happy with the naming. It is better to name the class
> iommu_error and the page-fault event io_page_fault. This makes it more
> clear what kind of fault it is.
>
>
> 	Joerg
>
>

Joerg,

Yes, iommu_error and io_page_fault sounds better. I will rename and send 
the updated patch.

-- Shuah

-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org | (970) 672-0658
