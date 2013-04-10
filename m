From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2 V5] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Wed, 10 Apr 2013 11:27:26 -0500
Message-ID: <516592EE.8050006@amd.com>
References: <1365609459-3378-1-git-send-email-suravee.suthikulpanit@amd.com>
	<CAKocOOML1-=SJGyvYNGK9hyOZp3UPd2WANcWqm1Joo7V6sAQpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKocOOML1-=SJGyvYNGK9hyOZp3UPd2WANcWqm1Joo7V6sAQpQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 4/10/2013 11:21 AM, Shuah Khan wrote:
> Good feature. Do you also plan to add decode logic for these flags.
> For example, RZ is only meaningful when PR=1, RW is only meaningful
> when
> PR=1, TR=0, and I=0, and so on? This additional logic will be useful.
>
> Reviewed-by: Shuah Khan<shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> -- Shuah
Additional filtering logic can also be added in the future.  This will 
also be important if we are planning on handling IOMMU errors.

Suravee
