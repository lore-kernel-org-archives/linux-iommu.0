From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/amd: Do not flush when device is busy
Date: Mon, 7 May 2018 08:26:51 -0500
Message-ID: <fa3576e4-ce6c-1e53-6605-e0ccc0ec1627@amd.com>
References: <20180504162233.11283-1-bigeasy@linutronix.de>
	<20180504162233.11283-4-bigeasy@linutronix.de>
	<0e5269ee-093f-9bb2-0a18-ee0e56fcf8f7@amd.com>
	<alpine.DEB.2.20.1805071430530.2795@hypnos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.20.1805071430530.2795-krIhswJi0h8yMciVaGeJ0d53zsg1cpMQ@public.gmane.org>
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
To: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/07/2018 07:38 AM, Anna-Maria Gleixner wrote:
> On Fri, 4 May 2018, Gary R Hook wrote:
>>
>> <grammar cop>
>>
>> The prior version of this comment appears 3 times in the file, and is
>> grammatically problematic every time. Can we simplify it to say
>>
>>   * This function makes the device visible in the domain
>>
>> Or some such? I.e. tidy up the two remaining comments?
>>
>> </grammar cop>
>>
> 
> Will fix it in a separate patch - but I only found 2 places where the
> prior version of this comment appears.

My mistake. You are, of course, correct.
