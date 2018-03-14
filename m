From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
Date: Wed, 14 Mar 2018 17:23:40 -0500
Message-ID: <e43c5e45-77e8-df20-ee90-1ac5cc3ad288@amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
	<152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
	<CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
	<30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com>
	<CAHp75VeySPBEeJKRXzmqfPey56J3rwr2-dPRzSYx+7a7TAC5rw@mail.gmail.com>
	<08d19301-7e8e-7586-8ffb-91823af0d31b@amd.com>
	<CAHp75VeEUCVSKLH0aobk=+GjVHWgO_OAKZRCx8gqDc9tWvESMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHp75VeEUCVSKLH0aobk=+GjVHWgO_OAKZRCx8gqDc9tWvESMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/14/2018 10:29 AM, Andy Shevchenko wrote:
> On Wed, Mar 14, 2018 at 5:24 PM, Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:
>> On 03/13/2018 03:23 PM, Andy Shevchenko wrote:
> 
>>>>>> +#include <linux/pci.h>
>>>>>> +#include <linux/iommu.h>
>>>>>> +#include <linux/debugfs.h>
> 
>>>>> Keep in order?
> 
>>>> What order would that be? These few needed files are listed in the same
>>>> order as which they appear in amd_iommu.c. I'm gonna need a preference
>>>> spelled out, please (and a rationale, so I may better understand).
> 
>>> To increase readability and avoid potential header duplication (here
>>> is can bus protocol implementation where the problem exists for real,
>>> even in new code!)
> 
>> With all due respect, I don't find that you clearly answered my question.
> 
> Alphabetical order I meant.

Thank you very much.

Gary
