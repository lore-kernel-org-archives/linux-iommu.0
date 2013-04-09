From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Add workaround to propery clearing IOMMU status
	register
Date: Tue, 9 Apr 2013 09:22:58 -0500
Message-ID: <51642442.7090908@amd.com>
References: <1365031144-2543-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130409094929.GE6858@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130409094929.GE6858-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 4/9/2013 4:49 AM, Joerg Roedel wrote:
> On Wed, Apr 03, 2013 at 06:19:04PM -0500, Suthikulpanit, Suravee wrote:
>> In the system with multiple IOMMU,this handling scheme complicates the
>> synchronization of the IOMMU data structures and status registers as
>> there could be multiple threads competing for the same IOMMU while
>> the other IOMMU could be left unhandled.
> I really like that change in the interrupt handling code to pull the
> different IOMMUs independently. But its problematic to change that in
> the same patch that adds an erratum workaround.
>
> Please move that erratum fix into a seperate small patch that we can
> backport to -stable and resend.
>
>
> 	Joerg
Joerg,

The reason I implemented the "per-thread IOMMU handling" and the 
"workaround" together in one patch
is because it simplifies the synchronization of clearing and checking 
the interrupt enabling bits.
In the previous implementation, we could end up having multiple threads 
trying to access the status register
at the same time.

Suravee
>
>
